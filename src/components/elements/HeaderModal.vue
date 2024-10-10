<template>
  <ion-header translucent>
    <ion-toolbar>
      <ion-title>{{ title }}</ion-title>
      <ion-buttons slot="end" class="ion-margin-end">
        <ion-button color="dark" @click="dismiss()">
          <ion-icon :icon="closeCircleOutline"></ion-icon>
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
  IonToolbar,
  modalController
} from '@ionic/vue'
import { closeCircleOutline } from 'ionicons/icons'

defineProps<{
  title: string
}>()

const dismiss = () => {
  modalController.dismiss()
}
</script>
