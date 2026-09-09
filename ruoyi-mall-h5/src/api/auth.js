import request from '@/utils/request'

// 手机号密码登录（后端 @RequestBody String，收到的是 JSON 字符串 {mobile,password}）
export function login(data) {
  return request({
    url: '/h5/account/login',
    method: 'post',
    data
  })
}

// 会员信息
export function getMemberInfo() {
  return request({
    url: '/h5/member/info',
    method: 'get'
  })
}
