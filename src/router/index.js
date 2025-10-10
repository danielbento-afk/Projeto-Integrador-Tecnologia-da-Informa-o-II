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
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: LoginView,
    meta: { hideHeader: true }
  },
  {
    path: '/register',
    name: 'Register',
    component: RegisterView,
     meta: { hideHeader: true }
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: DashboardView // E aqui...
  },
  // Verifique todos os outros da mesma forma...
  {
    path: '/courses',
    name: 'Courses',
    component: CoursesView
  },
  {
    path: '/availability',
    name: 'Availability',
    component: AvailabilityView
  },
  {
    path: '/schedule',
    name: 'Schedule',
    component: ScheduleView
  },
  {
    path: '/notifications',
    name: 'Notifications',
    component: NotificationsView
  },
  {
    path: '/profile',
    name: 'Profile',
    component: ProfileView
  },
  {
    path: '/reports',
    name: 'Reports',
    component: ReportsView
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

// A lógica de guarda de rotas pode ficar aqui, se você a manteve
router.beforeEach((to, from, next) => {
  const loggedIn = localStorage.getItem('user')
  if (to.matched.some(record => record.meta.requiresAuth) && !loggedIn) {
    next('/login')
  } else {
    next()
  }
})

export default router