<template>
  <ion-page mode="ios">
    <HeaderDefault title="Event List" />
    <ion-header collapse="condense">
      <ion-toolbar>
        <ion-title size="large">Event List</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true">
      <ion-refresher slot="fixed" @ion-refresh="handleRefresh">
        <ion-refresher-content></ion-refresher-content>
      </ion-refresher>
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Event List</ion-title>
        </ion-toolbar>
      </ion-header>

      <EventList />
    </ion-content>
  </ion-page>
</template>

<script lang="ts" setup>
import EventList from '@/components/EventList.vue'
import HeaderDefault from '@/components/elements/HeaderDefault.vue'
import {
  IonContent,
  IonHeader,
  IonPage,
  IonRefresher,
  IonRefresherContent,
  IonTitle,
  IonToolbar
} from '@ionic/vue'

const handleRefresh = () => {
  setTimeout(() => {
    window.location.reload()
  }, 500)
}
</script>
