import request from '@/utils/request'

// 全部分类（树形）
export function all() {
  return request({
    url: '/no-auth/category/all-categories',
    method: 'get'
  })
}

// 按 id 获取兄弟/子分类
export function byId(id) {
  return request({
    url: '/no-auth/category/category-by-id',
    method: 'get',
    params: { id }
  })
}
