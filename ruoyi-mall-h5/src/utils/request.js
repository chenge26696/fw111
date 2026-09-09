import axios from 'axios'
import { ElMessage } from 'element-plus'
import { getToken, removeToken } from './auth'

const service = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API,
  timeout: 15000
})

// 请求拦截：注入 Authorization
service.interceptors.request.use(
  config => {
    const token = getToken()
    if (token) {
      config.headers['Authorization'] = 'Bearer ' + token
    }
    return config
  },
  error => Promise.reject(error)
)

// 响应拦截：归一化（后端 ResponseEntity 直返 VO，无 code；错误返回 AjaxResult{code,msg,data}）
service.interceptors.response.use(
  response => {
    const res = response.data
    // 1. AjaxResult 风格（有 code 字段）
    if (res && typeof res === 'object' && 'code' in res) {
      if (res.code === 200) {
        return normalizePage(res)
      }
      if (res.code === 401) {
        handleUnauthorized()
        return Promise.reject(new Error(res.msg || '登录已过期'))
      }
      ElMessage.error(res.msg || '请求失败')
      return Promise.reject(new Error(res.msg || '请求失败'))
    }
    // 2. ResponseEntity 直返 VO（无 code）→ 包装为统一结构
    return normalizePage({ code: 200, msg: 'success', data: res })
  },
  error => {
    if (error.response && error.response.status === 401) {
      handleUnauthorized()
    } else {
      ElMessage.error(error.message || '网络异常')
    }
    return Promise.reject(error)
  }
)

// 分页字段映射：Spring Data Page 的 content/totalElements → records/total
function normalizePage(res) {
  const data = res.data
  if (data && typeof data === 'object' && Array.isArray(data.content) && 'totalElements' in data) {
    res.data = {
      records: data.content,
      total: data.totalElements,
      page: data.number,
      size: data.size
    }
  }
  return res
}

function handleUnauthorized() {
  removeToken()
  ElMessage.warning('登录已过期，请重新登录')
  setTimeout(() => {
    const redirect = encodeURIComponent(window.location.pathname + window.location.search)
    window.location.href = '/login?redirect=' + redirect
  }, 600)
}

export default service
