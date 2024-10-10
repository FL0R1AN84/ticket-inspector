<template>
  <ion-page mode="ios">
    <HeaderNavigation
      :route="`eventdetail/` + eventId"
      title="Attendee Detail"
    />
    <ion-header collapse="condense">
      <ion-toolbar>
        <ion-title>Attendee Detail</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-refresher slot="fixed" @ion-refresh="handleRefresh">
        <ion-refresher-content></ion-refresher-content>
      </ion-refresher>
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Attendee Detail</ion-title>
        </ion-toolbar>
      </ion-header>

      <AttendeeDetail v-if="auth" />
      <UserLogin
        :breakpoints="[0, 1]"
        :initial-breakpoint="1"
        title="Login"
        trigger="open-login"
      />
      <div v-if="!auth" id="open-login" class="login-button-container">
        <ion-button>
          <ion-text :color="isDark ? 'light' : 'dark'">Login</ion-text>
        </ion-button>
      </div>
    </ion-content>
  </ion-page>
</template>

<script lang="ts" setup>
import AttendeeDetail from '@/components/AttendeeDetail.vue'
import HeaderNavigation from '@/components/elements/HeaderNavigation.vue'
import {
  IonButton,
  IonContent,
  IonHeader,
  IonPage,
  IonRefresher,
  IonRefresherContent,
  IonText,
  IonTitle,
  IonToolbar
} from '@ionic/vue'
import UserLogin from '@/components/UserLogin.vue'
import { useDark } from '@vueuse/core'

const auth = localStorage.getItem('auth')
const eventId = localStorage.getItem('eventId')
const isDark = useDark()

const handleRefresh = () => {
  setTimeout(() => {
    window.location.reload()
  }, 500)
}
</script>

<style scoped>
.login-button-container {
  display: flex;
  justify-content: center;
}
</style>
