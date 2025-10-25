// src/router/index.js
import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView.vue'
import RegisterView from '../views/RegisterView.vue'
import DashboardView from '../views/DashboardView.vue'
import CoursesView from '../views/CoursesView.vue'
import AvailabilityView from '../views/AvailabilityView.vue'
import ScheduleView from '../views/ScheduleView.vue'
import NotificationsView from '../views/NotificationsView.vue'
import ProfileView from '../views/ProfileView.vue'
import ReportsView from '../views/ReportsView.vue'

const routes = [
  { path: '/', redirect: '/login' },

  // Não autenticadas
  { path: '/login', name: 'Login', component: LoginView, meta: { hideHeader: true } },
  { path: '/register', name: 'Register', component: RegisterView, meta: { hideHeader: true } },

  // Protegidas
  { path: '/dashboard', name: 'Dashboard', component: DashboardView, meta: { requiresAuth: true } },
  { path: '/courses', name: 'Courses', component: CoursesView, meta: { requiresAuth: true } },
  { path: '/availability', name: 'Availability', component: AvailabilityView, meta: { requiresAuth: true } },
  { path: '/schedule', name: 'Schedule', component: ScheduleView, meta: { requiresAuth: true } },
  { path: '/notifications', name: 'Notifications', component: NotificationsView, meta: { requiresAuth: true } },
  { path: '/profile', name: 'Profile', component: ProfileView, meta: { requiresAuth: true } },
  { path: '/reports', name: 'Reports', component: ReportsView, meta: { requiresAuth: true } }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

function isAuthenticated() {
  const token = localStorage.getItem('auth_token')
  const user = localStorage.getItem('user')
  return Boolean(token && user)
}

router.beforeEach((to, from, next) => {
  const loggedIn = isAuthenticated()

  // Bloqueia rotas privadas
  if (to.matched.some(r => r.meta.requiresAuth) && !loggedIn) {
    return next('/login')
  }

  // Evita que usuário já autenticado veja login/register
  if ((to.name === 'Login' || to.name === 'Register') && loggedIn) {
    return next('/dashboard')
  }

  next()
})

export default router
