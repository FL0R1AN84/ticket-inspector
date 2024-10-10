<template>
  <ion-button :color="color" :disabled="disabled">
    {{ title }}
  </ion-button>
</template>

<script lang="ts" setup>
import { IonButton } from '@ionic/vue'

defineProps<{
  color: string
  disabled?: boolean
  title: string
}>()
</script>
