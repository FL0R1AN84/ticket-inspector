<template>
  <ion-modal
    ref="modal"
    :breakpoints="breakpoints"
    :initial-breakpoint="initialBreakpoint"
    :trigger="trigger"
    mode="ios"
  >
    <div class="modal">
      <div class="content full">
        <HeaderModal title="Login" />
        <ion-content class="ion-padding">
          <div class="ion-text-center ion-padding app-logo">
            <img alt="TicketKings Logo" src="/TicketInspector_icon.png" />
          </div>
          <div class="ion-text-center">
            <ion-label>Ticket</ion-label>
            <ion-label color="primary">Inspector</ion-label>
          </div>

          <form novalidate @submit.prevent="onLogin">
            <ion-list :inset="true">
              <ion-item>
                <ion-input
                  v-model="username"
                  :spellcheck="false"
                  autocapitalize="off"
                  label="Username"
                  label-placement="floating"
                  name="username"
                  placeholder="demo"
                  required
                  type="text"
                ></ion-input>
              </ion-item>

              <ion-item>
                <ion-input
                  v-model="password"
                  label="Password"
                  label-placement="floating"
                  name="password"
                  placeholder="demo"
                  required
                  type="password"
                >
                  <ion-input-password-toggle
                    slot="end"
                    color="dark"
                  ></ion-input-password-toggle>
                </ion-input>
              </ion-item>
            </ion-list>

            <ion-row class="ion-padding" responsive-sm>
              <ion-col>
                <ion-button :disabled="!canSubmit" expand="block" type="submit">
                  <ion-text>Login</ion-text>
                  <ion-spinner
                    v-if="loading"
                    :color="isDark ? 'light' : 'dark'"
                    name="dots"
                  ></ion-spinner>
                </ion-button>
              </ion-col>
            </ion-row>
          </form>
        </ion-content>
      </div>
    </div>
  </ion-modal>
</template>

<script lang="ts" setup>
import router from '@/router'
import {
  IonButton,
  IonCol,
  IonContent,
  IonInput,
  IonInputPasswordToggle,
  IonItem,
  IonLabel,
  IonList,
  IonModal,
  IonRow,
  IonSpinner,
  IonText,
  toastController
} from '@ionic/vue'
import axios from 'axios'
import { computed, ref } from 'vue'
import { useDark } from '@vueuse/core'
import HeaderModal from '@/components/elements/HeaderModal.vue'

const isDark = useDark()
const networkError = ref(false)
const networkErrorMsg = ref('')
const password = ref('')
const username = ref('')
const loading = ref(false)

defineProps<{
  breakpoints: Array<number>
  initialBreakpoint: number
  eventId?: number
  securityCode?: string
  ticketId?: number
  title: string
  trigger: string
}>()

const canSubmit = computed(
  () => username.value.trim() !== '' && password.value.trim() !== ''
)

const onLogin = async () => {
  loading.value = true
  try {
    await axios
      .post(
        '/mocks/Login.json',
        {},
        {
          headers: {
            Authorization: `Basic ${btoa(`${username.value}:${password.value}`)}`
          }
        }
      )
      .then((response) => {
        const authHeader = response.config.headers.Authorization
        if (authHeader) {
          localStorage.setItem('auth', String(authHeader))
          router.go(0)
        }
      })
  } catch (error: any) {
    networkError.value = true
    networkErrorMsg.value =
      error.response.data.msg || error.response.data.message || error.message
    console.error(error)
    await presentErrorToast(networkErrorMsg.value)
  } finally {
    loading.value = false
  }
}

const errorCounter = ref(0)

const presentErrorToast = async (message: string) => {
  errorCounter.value += 1
  if (errorCounter.value >= 0) {
    message = 'Username or password is incorrect'
  }
  if (errorCounter.value >= 5) {
    message = 'Username or password is incorrect!!!'
  }
  if (errorCounter.value >= 10) {
    message = 'USERNAME or PASSWORD is INCORRECT!!!'
  }
  if (errorCounter.value >= 25) {
    message = 'YOU are not coming in here!'
  }
  const toast = await toastController.create({
    message: message,
    duration: 3000,
    position: 'bottom',
    color: 'danger'
  })
  await toast.present()
}
</script>

<style scoped>
ion-modal::part(content) {
  height: 677px;
}

.login-logo img {
  max-width: 150px;
}
</style>
