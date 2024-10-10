<template>
  <ion-header translucent>
    <ion-toolbar>
      <ion-title>{{ title }}</ion-title>
      <ion-buttons slot="start" class="ion-margin-start">
        <ion-button :href="route" color="dark">
          <ion-icon
            :icon="caretBackOutline"
            color="primary"
            size="large"
          ></ion-icon>
          ︎
        </ion-button>
      </ion-buttons>
      <ion-buttons slot="end" class="ion-margin-end">
        <ion-button color="dark" href="/">
          <ion-icon
            :icon="caretUpOutline"
            color="primary"
            size="large"
          ></ion-icon>
        </ion-button>
      </ion-buttons>
    </ion-toolbar>
  </ion-header>
</template>

<script lang="ts" setup>
import {
  IonButton,
  IonButtons,
  IonHeader,
  IonIcon,
  IonTitle,
  IonToolbar
} from '@ionic/vue'
import { caretBackOutline, caretUpOutline } from 'ionicons/icons'

defineProps<{
  title: string
  route: string
}>()
</script>
