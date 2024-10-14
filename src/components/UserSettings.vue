<template>
  <ion-modal
    ref="modal"
    :breakpoints="breakpoints"
    :initial-breakpoint="initialBreakpoint"
    :trigger="trigger"
    mode="ios"
  >
    <div class="modal">
      <div class="content small">
        <HeaderModal title="User Settings" />

        <ion-content>
          <ion-list>
            <ion-item>
              <ion-input
                v-model="apiKey"
                :maxlength="8"
                label="API key"
                label-placement="floating"
                placeholder="Enter your 8 character key here"
                @input="setApiKey"
              ></ion-input>
              <ion-icon
                v-if="debouncedIsApiKeyFilled"
                slot="end"
                :icon="checkmarkCircleOutline"
                color="success"
              ></ion-icon>
              <ion-button
                v-if="apiKey"
                slot="end"
                color="dark"
                fill="clear"
                @click="clearApiKey"
              >
                <ion-icon slot="icon-only" :icon="closeOutline"></ion-icon>
              </ion-button>
            </ion-item>
            <ion-item>
              <ion-toggle :disabled="true">Offline mode</ion-toggle>
            </ion-item>
            <ion-item lines="none">
              <ion-text color="danger"
                ><sub>This setting logs you out and deletes the API key</sub>
              </ion-text>
            </ion-item>
            <ion-item>
              <ion-toggle @click="resetSettings"
                >Reset all settings
              </ion-toggle>
            </ion-item>
          </ion-list>
          <ion-item lines="none">
            <sub> Version: {{ appVersion }} </sub>
          </ion-item>
        </ion-content>
      </div>
    </div>
  </ion-modal>
</template>

<script lang="ts" setup>
import {
  IonButton,
  IonContent,
  IonIcon,
  IonInput,
  IonItem,
  IonList,
  IonModal,
  IonText,
  IonToggle
} from '@ionic/vue'
import { checkmarkCircleOutline, closeOutline } from 'ionicons/icons'
import HeaderModal from './elements/HeaderModal.vue'
import packageJson from '../../package.json'
import { ref, watch } from 'vue'
import router from '@/router'

defineProps<{
  title: string
  trigger: string
  initialBreakpoint?: number
  breakpoints?: Array<number>
}>()

const apiKey = ref(localStorage.getItem('apiKey') || '')
const appVersion = packageJson.version

const setApiKey = () => {
  localStorage.setItem('apiKey', apiKey.value)
}

const debouncedIsApiKeyFilled = ref(false)

watch(apiKey, (newValue) => {
  setTimeout(() => {
    debouncedIsApiKeyFilled.value = newValue.length === 8
  }, 500)
})

const resetSettings = () => {
  localStorage.clear()
  router.go(0)
}

const clearApiKey = () => {
  apiKey.value = ''
  localStorage.removeItem('apiKey')
}
</script>

<style scoped>
ion-modal::part(content) {
  height: 278px;
}

#container {
  font-size: 10rem;
  margin: auto;
}
</style>
