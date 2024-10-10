<template>
  <ion-item class="ion-margin-top ion-margin-horizontal">
    <ion-label>
      <p>
        <ion-skeleton-text
          :animated="true"
          style="width: 100%"
        ></ion-skeleton-text>
      </p>
      <p>
        <ion-skeleton-text
          :animated="true"
          style="width: 50%"
        ></ion-skeleton-text>
      </p>
    </ion-label>
  </ion-item>
  <ion-item class="ion-margin-top ion-margin-horizontal" lines="none">
    <ion-thumbnail slot="start">
      <ion-skeleton-text :animated="true"></ion-skeleton-text>
    </ion-thumbnail>
    <ion-label>
      <h3>
        <ion-skeleton-text
          :animated="true"
          style="width: 80%"
        ></ion-skeleton-text>
      </h3>
      <p>
        <ion-skeleton-text
          :animated="true"
          style="width: 60%"
        ></ion-skeleton-text>
      </p>
    </ion-label>
  </ion-item>
</template>

<script lang="ts" setup>
import { IonItem, IonLabel, IonSkeletonText, IonThumbnail } from '@ionic/vue'
</script>

<style scoped>
ion-thumbnail {
  --size: 50px;
  --border-radius: 999px;
}
</style>
