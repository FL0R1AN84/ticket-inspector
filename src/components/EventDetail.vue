<template>
  <ion-card v-if="!loading">
    <ion-card-header>
      <ion-card-title v-html="title"></ion-card-title>
    </ion-card-header>
    <img :src="image" alt="Event image" />
  </ion-card>
  <SkeletonEventDetail v-if="loading" />
</template>

<script lang="ts" setup>
import {
  IonCard,
  IonCardHeader,
  IonCardTitle,
  toastController
} from '@ionic/vue'
import axios from 'axios'
import { onBeforeMount, onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import SkeletonEventDetail from '@/components/elements/SkeletonEventDetail.vue'

interface ApiResponse {
  events: Array<{
    id: number
    image: string
    title: string
  }>
}

const route = useRoute()
const eventId = ref<number | null>(null)

onBeforeMount(() => {
  eventId.value = Number(route.params.eventId)
})

const image = ref('')
const loading = ref(true)
const title = ref('')

onMounted(async () => {
  try {
    const response = await axios.get<ApiResponse>('src/mocks/Events.json')
    setTimeout(() => {
      const event = response.data.events.find(
        (event) => event.id === eventId.value
      )
      if (event) {
        title.value = event.title
        image.value = event.image
      }
      loading.value = false
    }, 1000)
  } catch (error) {
    console.error(error)
    const toast = await toastController.create({
      message:
        'Connection error, either the server is unreachable or you are not connected to the Internet.',
      duration: 10000,
      position: 'middle',
      color: 'danger'
    })
    await toast.present()
    loading.value = false
  }
})
</script>

<style scoped>
img {
  height: 240px;
  width: 100%;
  object-fit: cover;
}
</style>

<style scoped>
img {
  height: 240px;
  width: 100%;
  object-fit: cover;
}
</style>
