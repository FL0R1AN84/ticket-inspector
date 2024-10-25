<template>
  <div v-if="!loading">
    <ion-searchbar
      :debounce="1000"
      animated
      placeholder="Search for attendees"
      @ion-input="handleInput($event)"
    >
    </ion-searchbar>

    <div v-if="attendees.length > 0 && statChart">
      <ion-item>
        <ion-label
          :class="{ 'active-label': activeLabel === 'total' }"
          @click="
            () => {
              setActiveLabel('total')
              resetAttendees()
            }
          "
        >
          Total attendees:
        </ion-label>
        <ion-badge color="dark"
          >{{ checkedInCount + checkedOutCount }}
        </ion-badge>
      </ion-item>
      <ion-item>
        <ion-label
          :class="{ 'active-label': activeLabel === 'checkedIn' }"
          @click="
            () => {
              setActiveLabel('checkedIn')
              checkedInFilter()
            }
          "
        >
          CheckedIn:
        </ion-label>
        <ion-badge color="success">{{ checkedInCount }}</ion-badge>
      </ion-item>
      <ion-item>
        <ion-label
          :class="{ 'active-label': activeLabel === 'checkedOut' }"
          @click="
            () => {
              setActiveLabel('checkedOut')
              checkedOutFilter()
            }
          "
        >
          Not CheckedIn:
        </ion-label>
        <ion-badge color="danger">{{ checkedOutCount }}</ion-badge>
      </ion-item>
    </div>

    <div v-if="attendees.length > 0 && !statChart">
      <ion-item>
        <ion-label>Attendees found:</ion-label>
        <ion-badge color="light">{{ attendees.length }}</ion-badge>
      </ion-item>
    </div>

    <div
      v-if="attendees.length > 0"
      :class="{ 'button-container': true, expanded: statChart }"
    >
      <ion-button color="light" shape="round" @click="statChart = !statChart">
        <ion-icon
          slot="icon-only"
          :icon="statChart ? chevronUp : chevronDown"
        ></ion-icon>
      </ion-button>
    </div>

    <ion-card
      v-if="attendees.length === 0 && authorId === userId"
      class="ion-padding"
    >
      <ion-card-title>No attendees found</ion-card-title>
    </ion-card>

    <div v-for="attendee in results" :key="attendee.id">
      <router-link
        :to="{ name: 'AttendeeDetail', params: { attendeeId: attendee.id } }"
      >
        <ion-card class="ion-padding">
          <ion-button
            :color="attendee.checked_in ? 'success' : 'danger'"
            class="ion-float-start ion-margin-end"
            shape="round"
          ></ion-button>
          <ion-card-title>{{ attendee.name }}</ion-card-title>
          <ion-card-subtitle
            v-if="!attendee.checked_in"
            class="ion-margin-start"
            >Status: Checked out
          </ion-card-subtitle>
          <ion-card-subtitle v-if="attendee.checked_in"
            >Status: Checked in
          </ion-card-subtitle>
        </ion-card>
      </router-link>
    </div>
  </div>
  <SkeletonAttendeeList v-if="loading" />
</template>

<script lang="ts" setup>
import axios from 'axios'
import { onMounted, ref } from 'vue'
import {
  IonBadge,
  IonButton,
  IonCard,
  IonCardSubtitle,
  IonCardTitle,
  IonIcon,
  IonItem,
  IonLabel,
  IonSearchbar
} from '@ionic/vue'
import SkeletonAttendeeList from '@/components/elements/SkeletonAttendeeList.vue'
import { chevronDown, chevronUp } from 'ionicons/icons'

interface ApiResponse {
  attendees: any
  tickets: any
  post_id: any
}

const activeLabel = ref('total')
const attendees = ref()
const checkedInCount = ref(0)
const checkedOutCount = ref(0)
const loading = ref(true)
const postId = ref<any[]>([localStorage.getItem('eventId')])
const statChart = ref(false)
const tickets = ref()

const setActiveLabel = (label: string) => {
  activeLabel.value = label
}

onMounted(async () => {
  try {
    const auth = localStorage.getItem('auth')

    const response = await axios.get<ApiResponse>('/mocks/Attendee.json', {
      headers: {
        Authorization: auth ? `${auth}` : undefined
      }
    })
    setTimeout(() => {
      tickets.value = response.data.tickets
      const eventId = localStorage.getItem('eventId')
      postId.value = tickets.value.filter(
        (attendee: any) => attendee.post_id === Number(eventId)
      )
      attendees.value = postId.value
        .map((a: any) => a.attendees)
        .flat()
        .sort((a: any, b: any) => (a.name > b.name ? 1 : -1))
      checkedInCount.value = attendees.value.filter(
        (attendee: any) => attendee.checked_in
      ).length
      checkedOutCount.value = attendees.value.filter(
        (attendee: any) => !attendee.checked_in
      ).length
    }, 1500)
  } catch (error) {
    console.error(error)
  } finally {
    loading.value = false
  }
})

const results = ref(attendees)

const resetAttendees = () => {
  return (results.value = postId.value
    .map((a: any) => a.attendees)
    .flat()
    .sort((a: any, b: any) => (a.title > b.title ? 1 : -1)))
}
const handleInput = (event: any) => {
  const query = event.target.value.toLowerCase()
  if (query.length >= 3) {
    results.value = attendees.value.filter(
      (d: any) => d.title.toLowerCase().indexOf(query) > -1
    )
  }
  if (!query || query.length <= 2) {
    resetAttendees()
  }
}

const checkedInFilter = () => {
  results.value = attendees.value.filter((attendee: any) => attendee.checked_in)
  if (attendees.value.length === 0) {
    resetAttendees()
    checkedInFilter()
  }
}

const checkedOutFilter = () => {
  results.value = attendees.value.filter(
    (attendee: any) => !attendee.checked_in
  )
  if (attendees.value.length === 0) {
    resetAttendees()
    checkedOutFilter()
  }
}
</script>

<style scoped>
a {
  text-decoration: none;
}

.active-label {
  font-weight: bold;
  color: var(--ion-color-primary);
  transition:
    color 0.3s ease,
    font-weight 0.3s ease;
}

.button-container {
  display: flex;
  justify-content: center;
  transition: transform 0.6s ease;
}

.button-container.expanded {
  transform: translateY(10px);
}
</style>
