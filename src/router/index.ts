import TabPage from '@/views/TabPage.vue'
import { createRouter, createWebHistory } from '@ionic/vue-router'
import { RouteRecordRaw } from 'vue-router'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    redirect: '/eventlist'
  },
  {
    path: '/',
    component: TabPage,
    children: [
      {
        path: '/attendeedetail/:attendeeId',
        name: 'AttendeeDetail',
        component: () => import('@/views/AttendeeDetailPage.vue')
      },
      {
        path: '',
        redirect: '/eventlist'
      },
      {
        path: 'eventlist',
        component: () => import('@/views/EventListPage.vue')
      },
      {
        path: '/eventdetail/:eventId',
        name: 'EventDetail',
        component: () => import('@/views/EventDetailPage.vue')
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
