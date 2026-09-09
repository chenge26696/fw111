<template>
  <div class="product-card" @click="goDetail">
    <div class="pic-wrap">
      <img :src="product.pic || defaultImg" :alt="product.name" @error="onImgError" />
    </div>
    <div class="info">
      <p class="name">{{ product.name }}</p>
      <div class="bottom">
        <span class="price">￥{{ formatPrice(product.price) }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'

const props = defineProps({ product: { type: Object, required: true } })
const router = useRouter()
const defaultImg = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200"><rect width="200" height="200" fill="%23f5f5f5"/><text x="100" y="105" text-anchor="middle" fill="%23bbb" font-size="14">暂无图片</text></svg>'

function formatPrice(p) {
  if (p === null || p === undefined) return '0.00'
  return Number(p).toFixed(2)
}
function onImgError(e) {
  e.target.src = defaultImg
}
function goDetail() {
  router.push('/goods/' + props.product.id)
}
</script>

<style scoped>
.product-card {
  background: #fff;
  border-radius: 6px;
  overflow: hidden;
  cursor: pointer;
  transition: box-shadow 0.2s, transform 0.2s;
  border: 1px solid var(--border);
}
.product-card:hover {
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
  transform: translateY(-2px);
}
.pic-wrap {
  width: 100%;
  aspect-ratio: 1 / 1;
  overflow: hidden;
  background: #f9f9f9;
}
.pic-wrap img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.info {
  padding: 8px 10px 10px;
}
.name {
  font-size: 14px;
  color: var(--text-main);
  line-height: 1.4;
  height: 39px;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  margin-bottom: 8px;
}
.price {
  color: var(--price);
  font-size: 18px;
  font-weight: 700;
}
</style>
