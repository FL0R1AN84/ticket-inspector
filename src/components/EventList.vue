<template>
  <div v-for="event in events" :key="event.id">
    <router-link
      :to="{ name: 'EventDetail', params: { eventId: event.id } }"
      @click="setEventId(event.id)"
    >
      <ion-card>
        <img :src="event.image" alt="Event image" />
        <ion-card-header>
          <ion-card-title v-html="event.title"></ion-card-title>
          <ion-card-subtitle
            >{{ formatDate(event.start_date) }}
          </ion-card-subtitle>
        </ion-card-header>
      </ion-card>
    </router-link>
  </div>
  <SkeletonEventList v-if="!events" />
  <SkeletonEventList v-if="!events" />
</template>

<script lang="ts" setup>
import {
  IonCard,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  toastController
} from '@ionic/vue'
import axios from 'axios'
import { onMounted, ref } from 'vue'
import { addMonths, addYears, isPast } from 'date-fns'
import SkeletonEventList from '@/components/elements/SkeletonEventList.vue'

interface ApiResponse {
  events: any
}

const events = ref()

const addOneMonthOrYearIfPast = (date: string, id: number) => {
  const parsedDate = new Date(date)
  if (isPast(parsedDate)) {
    if (id === 4) {
      return addYears(parsedDate, 1)
        .toISOString()
        .slice(0, 19)
        .replace('T', ' ')
    }
    return addMonths(parsedDate, 1).toISOString().slice(0, 19).replace('T', ' ')
  }
  return date
}

onMounted(async () => {
  try {
    const response = await axios.get<ApiResponse>(
      './../../public/mocks/Events.json'
    )
    setTimeout(() => {
      events.value = response.data.events.map((event: any) => ({
        ...event,
        start_date: addOneMonthOrYearIfPast(event.start_date, event.id)
      }))
    }, 500)
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
  }
})

const formatDate = (value: string) => {
  if (value) {
    return new Intl.DateTimeFormat('en-EN', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: 'numeric',
      minute: 'numeric'
    }).format(new Date(value))
  }
  return ''
}

const setEventId = (eventId: number) => {
  localStorage.setItem('eventId', String(eventId))
}
</script>

<style scoped>
a {
  text-decoration: none;
}

img {
  height: 240px;
  width: 100%;
  object-fit: cover;
}
</style>
