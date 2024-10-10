<template>
  <ion-page mode="ios">
    <div class="smartphone">
      <div class="content">
        <EventScanner
          :breakpoints="[0, 1]"
          :initial-breakpoint="1"
          title="Event Scanner"
          trigger="open-scanner"
        />
        <UserSettings
          :breakpoints="[0, 0.24]"
          :initial-breakpoint="0.24"
          title="User Settings"
          trigger="open-settings"
        />
        <ion-tabs>
          <ion-router-outlet />
          <ion-tab-bar v-if="auth" slot="bottom" translucent>
            <ion-tab-button id="open-settings" tab="settings">
              <ion-icon
                :ios="cogOutline"
                :md="settingsOutline"
                aria-hidden="true"
              />
            </ion-tab-button>

            <ion-tab-button id="open-scanner" tab="scanner">
              <ion-fab v-if="route.path !== '/eventlist'">
                <ion-fab-button color="primary">
                  <ion-icon
                    :icon="camera"
                    aria-hidden="true"
                    color="secondary"
                  />
                </ion-fab-button>
              </ion-fab>
            </ion-tab-button>
          </ion-tab-bar>
        </ion-tabs>
      </div>
    </div>
  </ion-page>
</template>

<script lang="ts" setup>
import {
  IonFab,
  IonFabButton,
  IonIcon,
  IonPage,
  IonRouterOutlet,
  IonTabBar,
  IonTabButton,
  IonTabs
} from '@ionic/vue'
import { camera, cogOutline, settingsOutline } from 'ionicons/icons'
import EventScanner from '@/components/EventScanner.vue'
import UserSettings from '@/components/UserSettings.vue'
import { useRoute } from 'vue-router'

const auth = localStorage.getItem('auth')
const route = useRoute()
</script>

<style scoped>
ion-tab-bar {
  height: 75px;
}

ion-fab-button {
  --background: var(--ion-color-dark);
  transition: transform 0.2s ease-in-out;

  &:active {
    transform: scale(0.95);
  }
}
</style>
