<template>
  <ion-header translucent>
    <ion-toolbar>
      <ion-title>{{ title }}</ion-title>
    </ion-toolbar>
  </ion-header>
</template>

<script lang="ts" setup>
import { IonHeader, IonTitle, IonToolbar } from '@ionic/vue'

defineProps<{
  title: string
}>()
</script>
