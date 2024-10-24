<template>
  <ion-page mode="ios">
    <div :class="containerClass">
      <div class="content">
        <EventScanner
          v-if="route.path !== '/eventlist'"
          :breakpoints="[0, 0.98]"
          :initial-breakpoint="0.98"
          title="Event Scanner"
          trigger="open-scanner"
        />
        <UserLogin
          v-if="route.path === '/eventlist'"
          :breakpoints="[0, 0.98]"
          :initial-breakpoint="0.98"
          title="Login"
          trigger="open-login"
        />
        <UserSettings
          :breakpoints="[0, 0.24]"
          :initial-breakpoint="0.24"
          title="User Settings"
          trigger="open-settings"
        />
        <ion-tabs>
          <ion-router-outlet />
          <ion-tab-bar slot="bottom" translucent>
            <ion-tab-button id="open-settings" tab="settings">
              <ion-icon
                :ios="cogOutline"
                :md="settingsOutline"
                aria-hidden="true"
              />
            </ion-tab-button>

            <ion-tab-button
              v-if="route.path === '/eventlist'"
              id="open-login"
              tab="login"
            >
              <ion-fab>
                <ion-fab-button color="primary">
                  <ion-icon
                    :icon="auth ? person : personOutline"
                    aria-hidden="true"
                    color="secondary"
                  />
                </ion-fab-button>
              </ion-fab>
            </ion-tab-button>

            <ion-tab-button
              v-if="route.path !== '/eventlist'"
              id="open-scanner"
              :disabled="!auth"
              tab="scanner"
            >
              <ion-fab>
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
import {
  camera,
  cogOutline,
  person,
  personOutline,
  settingsOutline
} from 'ionicons/icons'
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import EventScanner from '@/components/EventScanner.vue'
import UserSettings from '@/components/UserSettings.vue'
import UserLogin from '@/components/UserLogin.vue'

const auth = localStorage.getItem('auth')
const route = useRoute()

const isMobileDevice = () => {
  return /Mobi|Android/i.test(navigator.userAgent)
}

const containerClass = computed(() => {
  return isMobileDevice() ? '' : 'smartphone'
})
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
