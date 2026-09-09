<template>
  <div v-loading="loading" class="profile-page">
    <!-- 会员信息卡 -->
    <div class="user-card">
      <el-avatar :size="72" :src="member.avatar">{{ member.nickname?.charAt(0) || 'U' }}</el-avatar>
      <div class="user-info">
        <div class="nickname">{{ member.nickname || '会员' }}</div>
        <div class="phone">{{ member.phone }}</div>
        <div class="extras">
          <el-tag v-if="member.level !== undefined" size="small">等级 Lv{{ member.level }}</el-tag>
          <el-tag v-if="member.integral !== undefined" size="small" type="warning">积分 {{ member.integral }}</el-tag>
          <el-tag v-if="member.city" size="small" type="info">{{ member.city }}</el-tag>
        </div>
      </div>
    </div>

    <!-- 订单数量统计 -->
    <div class="stat-card">
      <div class="stat-title">我的订单</div>
      <div class="stat-grid">
        <div class="stat-item" @click="goOrders('0')">
          <el-badge :value="counts.unpaid || 0" :hidden="!counts.unpaid" :max="99">
            <el-icon :size="28"><Wallet /></el-icon>
          </el-badge>
          <span>待付款</span>
        </div>
        <div class="stat-item" @click="goOrders('1')">
          <el-badge :value="counts.nosend || 0" :hidden="!counts.nosend" :max="99">
            <el-icon :size="28"><Box /></el-icon>
          </el-badge>
          <span>待发货</span>
        </div>
        <div class="stat-item" @click="goOrders('2')">
          <el-badge :value="counts.noget || 0" :hidden="!counts.noget" :max="99">
            <el-icon :size="28"><Van /></el-icon>
          </el-badge>
          <span>待收货</span>
        </div>
        <div class="stat-item" @click="goOrders('3')">
          <el-icon :size="28"><CircleCheck /></el-icon>
          <span>已完成</span>
        </div>
      </div>
    </div>

    <!-- 功能入口 -->
    <div class="menu-card">
      <div class="menu-item" @click="$router.push('/orders')">
        <el-icon><List /></el-icon>
        <span class="menu-label">全部订单</span>
        <el-icon class="arrow"><ArrowRight /></el-icon>
      </div>
      <div class="menu-item" @click="$router.push('/cart')">
        <el-icon><ShoppingCart /></el-icon>
        <span class="menu-label">购物车</span>
        <el-icon class="arrow"><ArrowRight /></el-icon>
      </div>
      <div class="menu-item" @click="$router.push('/address')">
        <el-icon><Location /></el-icon>
        <span class="menu-label">收货地址</span>
        <el-icon class="arrow"><ArrowRight /></el-icon>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Wallet, Box, Van, CircleCheck, List, ShoppingCart, Location, ArrowRight } from '@element-plus/icons-vue'
import { getMemberInfo } from '@/api/auth'
import { countOrder } from '@/api/order'

const router = useRouter()
const loading = ref(false)
const member = reactive({})
const counts = reactive({ unpaid: 0, nosend: 0, noget: 0, aftersale: 0 })

onMounted(() => {
  loadMember()
  loadCounts()
})

async function loadMember() {
  loading.value = true
  try {
    const res = await getMemberInfo()
    Object.assign(member, res.data || {})
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

async function loadCounts() {
  try {
    const res = await countOrder()
    Object.assign(counts, res.data || {})
  } catch (e) {
    console.error(e)
  }
}

function goOrders(status) {
  router.push({ path: '/orders' })
  // 通过 query 控制状态需要 Orders 页支持，这里简化为跳订单页手动切换
}
</script>

<style scoped>
.profile-page {
  min-height: 400px;
}
.user-card {
  background: linear-gradient(135deg, #ff4400, #ff7a45);
  border-radius: 8px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 18px;
  color: #fff;
  margin-bottom: 16px;
}
.user-info .nickname {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 4px;
}
.user-info .phone {
  font-size: 13px;
  opacity: 0.9;
  margin-bottom: 8px;
}
.extras {
  display: flex;
  gap: 8px;
}
.stat-card, .menu-card {
  background: #fff;
  border-radius: 8px;
  padding: 16px 20px;
  margin-bottom: 16px;
}
.stat-title {
  font-size: 15px;
  font-weight: 600;
  margin-bottom: 14px;
}
.stat-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  text-align: center;
}
.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  color: var(--text-main);
}
.stat-item span {
  font-size: 13px;
}
.stat-item:hover {
  color: var(--primary);
}
.menu-item {
  display: flex;
  align-items: center;
  padding: 14px 0;
  border-bottom: 1px solid var(--border);
  cursor: pointer;
}
.menu-item:last-child {
  border-bottom: none;
}
.menu-item .menu-label {
  flex: 1;
  margin-left: 8px;
  font-size: 14px;
}
.menu-item .arrow {
  color: var(--text-sub);
}
</style>
