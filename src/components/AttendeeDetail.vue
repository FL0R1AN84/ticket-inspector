<template>
  <div v-if="!loading">
    <ion-card class="ion-padding">
      <ion-button
        :color="attendee?.checked_in ? 'success' : 'danger'"
        class="ion-float-start ion-margin-end"
        shape="round"
      ></ion-button>

      <ion-card-title>{{ attendee?.name }}</ion-card-title>
      <ion-card-subtitle v-if="!attendee?.checked_in" class="ion-margin-start"
        >Status: Check out
      </ion-card-subtitle>
      <ion-card-subtitle v-if="attendee?.checked_in"
        >Status: Checked in
      </ion-card-subtitle>
    </ion-card>
    <ion-card class="ion-padding">
      <ion-card-title>Ticket Id.: {{ attendee?.ticket_id }}</ion-card-title>
      <ion-card-title
        >Ticket Price: {{ attendee?.price }}
        <span v-html="attendee?.currency"></span>
      </ion-card-title>
    </ion-card>
    <ion-card class="ion-padding">
      <ion-card-subtitle> {{ attendee?.name }}</ion-card-subtitle>
      <ion-card-subtitle> {{ attendee?.email }}</ion-card-subtitle>
    </ion-card>
    <div class="ion-padding">
      <ButtonDefault
        :disabled="attendee?.checked_in"
        color="success"
        title="Check in"
        @click="checkIn"
      />
      <ButtonDefault
        :disabled="!attendee?.checked_in"
        color="danger"
        title="Check out"
        @click="checkOut"
      />
    </div>
  </div>
  <SkeletonAttendeeDetail v-if="loading" />
</template>

<script lang="ts" setup>
import {
  IonButton,
  IonCard,
  IonCardSubtitle,
  IonCardTitle,
  toastController
} from '@ionic/vue'
import axios from 'axios'
import { onBeforeMount, onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import SkeletonAttendeeDetail from './elements/SkeletonAttendeeDetail.vue'
import ButtonDefault from '@/components/elements/ButtonDefault.vue'

interface Attendee {
  id: number
  post_id: number
  checked_in: boolean
  name: string
  email: string
  ticket_id: string
  price: string
  currency: string
}

interface ApiResponse {
  tickets: {
    id: number
    post_id: number
    attendees: Attendee[]
  }[]
}

const route = useRoute()

const attendeeId = ref<string | string[]>('')
const attendee = ref<Attendee | null>(null)
const loading = ref(true)

onBeforeMount(() => {
  attendeeId.value = route.params.attendeeId
})

onMounted(async () => {
  try {
    const auth = localStorage.getItem('auth')
    const eventId = localStorage.getItem('eventId')

    const response = await axios.get<ApiResponse>('src/mocks/Attendee.json', {
      headers: {
        Authorization: auth ? `${auth}` : undefined
      }
    })

    setTimeout(() => {
      const filteredAttendees = response.data.tickets
        .filter((ticket) => ticket.post_id === Number(eventId))
        .flatMap((ticket) => ticket.attendees)

      attendee.value =
        filteredAttendees.find(
          (attendee) => attendee.id === Number(attendeeId.value)
        ) || null
      loading.value = false
    }, 1500) // Set timeout to 1500 milliseconds
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

const checkIn = async () => {
  try {
    const auth = localStorage.getItem('auth')
    await axios.put(
      'src/mocks/Attendee.json',
      {
        check_in: true
      },
      {
        headers: {
          Authorization: auth ? `${auth}` : undefined
        }
      }
    )
    if (attendee.value) {
      attendee.value.checked_in = true
    }
  } catch (error) {
    console.error(error)
  }
}

const checkOut = async () => {
  try {
    const auth = localStorage.getItem('auth')
    await axios.put(
      'src/mocks/Attendee.json',
      {
        check_in: false
      },
      {
        headers: {
          Authorization: auth ? `${auth}` : undefined
        }
      }
    )
    if (attendee.value) {
      attendee.value.checked_in = false
    }
  } catch (error) {
    console.error(error)
  }
}
</script>

<style scoped></style>
