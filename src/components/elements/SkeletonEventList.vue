<template>
  <ion-item class="ion-margin-top ion-margin-horizontal" lines="none">
    <ion-label>
      <ion-thumbnail class="ion-margin-bottom">
        <ion-skeleton-text :animated="true"></ion-skeleton-text>
      </ion-thumbnail>
      <p>
        <ion-skeleton-text
          :animated="true"
          style="width: 60%"
        ></ion-skeleton-text>
      </p>
      <p>
        <ion-skeleton-text
          :animated="true"
          style="width: 90%"
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
  height: 200px;
  width: 100%;
  --border-radius: 8px;
}
</style>
