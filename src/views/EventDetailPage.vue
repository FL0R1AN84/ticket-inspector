<template>
  <ion-page mode="ios">
    <HeaderNavigation route="eventlist" title="Event Detail" />
    <ion-header collapse="condense">
      <ion-toolbar>
        <ion-title>Event Detail</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-refresher slot="fixed" @ion-refresh="handleRefresh">
        <ion-refresher-content></ion-refresher-content>
      </ion-refresher>
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Event Detail</ion-title>
        </ion-toolbar>
      </ion-header>

      <EventDetail />
      <AttendeeList v-if="auth" />
      <UserLogin
        :breakpoints="[0, 1]"
        :initial-breakpoint="1"
        title="Login"
        trigger="open-login"
      />
      <div v-if="!auth" id="open-login" class="login-button-container">
        <ButtonDefault color="primary" title="Login" />
      </div>
    </ion-content>
  </ion-page>
</template>

<script lang="ts" setup>
import AttendeeList from '@/components/AttendeeList.vue'
import HeaderNavigation from '@/components/elements/HeaderNavigation.vue'
import EventDetail from '@/components/EventDetail.vue'
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
import ButtonDefault from '@/components/elements/ButtonDefault.vue'

const auth = localStorage.getItem('auth')

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
