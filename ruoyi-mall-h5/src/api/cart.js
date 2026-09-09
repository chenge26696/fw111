import request from '@/utils/request'

// 购物车商品数量（角标）
export function count() {
  return request({
    url: '/h5/cart/goodscount',
    method: 'get'
  })
}

// 购物车列表
export function list() {
  return request({
    url: '/h5/cart/list',
    method: 'get'
  })
}

// 加入购物车
export function add(data) {
  return request({
    url: '/h5/cart/add',
    method: 'post',
    data
  })
}

// 修改购物车（数量等，需带 id）
export function modify(data) {
  return request({
    url: '/h5/cart/modify',
    method: 'post',
    data
  })
}

// 删除购物车项（后端 @RequestBody String，收到 JSON 数组字符串 "[1,2]"）
export function remove(ids) {
  return request({
    url: '/h5/cart/remove',
    method: 'delete',
    data: JSON.stringify(ids)
  })
}
