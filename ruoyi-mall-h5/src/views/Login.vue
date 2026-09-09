<template>
  <div class="login-page">
    <div class="login-box">
      <div class="brand">
        <div class="logo-text">若依商城</div>
        <p class="slogan">欢迎登录，开启购物之旅</p>
      </div>
      <el-form ref="formRef" :model="form" :rules="rules" @submit.prevent="handleLogin">
        <el-form-item prop="mobile">
          <el-input v-model="form.mobile" placeholder="请输入手机号" :prefix-icon="User" size="large" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password" type="password" placeholder="请输入密码" :prefix-icon="Lock" size="large" show-password @keyup.enter="handleLogin" />
        </el-form-item>
        <el-button type="primary" size="large" class="submit-btn" :loading="loading" @click="handleLogin">登 录</el-button>
        <div class="tips">
          <span>还没有账号？联系管理员开通</span>
        </div>
        <div class="back-home">
          <el-button text @click="$router.push('/home')">返回首页</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { User, Lock } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { login, getMemberInfo } from '@/api/auth'
import { setToken, setUser } from '@/utils/auth'

const route = useRoute()
const router = useRouter()
const formRef = ref(null)
const loading = ref(false)

const form = reactive({ mobile: '', password: '' })
const rules = {
  mobile: [{ required: true, message: '请输入手机号', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

async function handleLogin() {
  if (!formRef.value) return
  await formRef.value.validate(async (valid) => {
    if (!valid) return
    loading.value = true
    try {
      const res = await login({ mobile: form.mobile, password: form.password })
      const token = res.data?.token
      if (!token) {
        ElMessage.error('登录失败：未返回 token')
        return
      }
      setToken(token)
      // 拉取会员信息
      let userObj = { token, username: form.mobile }
      try {
        const mres = await getMemberInfo()
        const m = mres.data || {}
        userObj = {
          token,
          id: m.id,
          username: form.mobile,
          nickname: m.nickname,
          phone: m.phone,
          avatar: m.avatar,
          role: 'USER'
        }
      } catch (e) {
        // 会员信息拉取失败也不阻塞，token 已存
      }
      setUser(userObj)
      ElMessage.success('登录成功')
      const redirect = route.query.redirect
      router.push(redirect ? decodeURIComponent(redirect) : '/home')
    } catch (e) {
      // 拦截器已提示
    } finally {
      loading.value = false
    }
  })
}
</script>

<style scoped>
.login-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #ff4400 0%, #ff7a45 100%);
  display: flex;
  align-items: center;
  justify-content: center;
}
.login-box {
  width: 380px;
  background: #fff;
  border-radius: 12px;
  padding: 40px 36px 32px;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
}
.brand {
  text-align: center;
  margin-bottom: 28px;
}
.logo-text {
  font-size: 26px;
  font-weight: 800;
  color: var(--primary);
}
.slogan {
  color: var(--text-sub);
  font-size: 13px;
  margin-top: 8px;
}
.submit-btn {
  width: 100%;
  margin-top: 6px;
  background: var(--primary);
  border-color: var(--primary);
}
.tips {
  text-align: center;
  color: var(--text-sub);
  font-size: 12px;
  margin-top: 16px;
}
.back-home {
  text-align: center;
  margin-top: 8px;
}
</style>
