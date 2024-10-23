<template>
  <ion-modal
    ref="modal"
    :breakpoints="breakpoints"
    :initial-breakpoint="initialBreakpoint"
    :trigger="trigger"
    mode="ios"
    @ion-modal-did-dismiss="dismiss"
  >
    <div class="modal">
      <div class="content full">
        <HeaderModal title="Event Scanner" />
        <QrcodeStream
          :paused="paused"
          @detect="onDetect"
          @error="onError"
          @camera-on="onCameraOn"
          @camera-off="onCameraOff"
        >
          <div v-show="showScanConfirmation" class="scan-confirmation">
            <ion-spinner v-if="loading"></ion-spinner>
            <ion-icon
              v-if="!loading && checkedIn"
              :icon="checkmarkCircleOutline"
              class="large-icon"
              color="success"
            ></ion-icon>
            <ion-icon
              v-if="!loading && networkError"
              :icon="alertOutline"
              class="large-icon"
              color="danger"
            ></ion-icon>
          </div>
        </QrcodeStream>
      </div>
    </div>
  </ion-modal>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { QrcodeStream } from 'vue-qrcode-reader'
import { IonIcon, IonModal, IonSpinner, toastController } from '@ionic/vue'
import HeaderModal from '@/components/elements/HeaderModal.vue'
import axios from 'axios'
import { alertOutline, checkmarkCircleOutline } from 'ionicons/icons'
import router from '@/router'

defineProps<{
  breakpoints: Array<number>
  initialBreakpoint: number
  eventId?: number
  securityCode?: string
  ticketId?: number
  title: string
  trigger: string
}>()

const checkedIn = ref(false)
const networkError = ref(false)
const networkErrorMsg = ref('')
const paused = ref(false)
const result = ref('')
const showScanConfirmation = ref(false)
const loading = ref(false)

const dismiss = () => {
  router.go(0)
}

const onCameraOn = () => {
  showScanConfirmation.value = false
  checkApiKeyAndShowToast()
}

const onCameraOff = () => {
  showScanConfirmation.value = true
}

const onDetect = async (detectedCodes: any[]) => {
  loading.value = true
  result.value = JSON.stringify(detectedCodes.map((code) => code.rawValue))
  paused.value = loading.value

  const apiKey = localStorage.getItem('apiKey')
  const url = new URL(detectedCodes[0].rawValue)
  const params = new URLSearchParams(url.search)
  const eventId = params.get('event_id')
  const ticketId = params.get('ticket_id')
  const securityCode = params.get('security_code')
  try {
    const auth = localStorage.getItem('auth')
    await axios.get(
      `https://ticket-inspector.vercel.app/?ticket_id=${ticketId}&event_id=${eventId}&api_key=${apiKey}&security_code=${securityCode}`,
      {
        headers: {
          Authorization: auth ? `${auth}` : undefined
        }
      }
    )
    await presentToast()
  } catch (error: any) {
    if (error.response && error.response.status === 400) {
      networkErrorMsg.value = 'This QR code is not a valid ticket!'
    } else {
      networkErrorMsg.value =
        error.response.data.msg || error.response.data.message || error.message
    }
    networkError.value = true
    console.error(error)
    await presentErrorToast(networkErrorMsg.value)
  } finally {
    loading.value = false
    if (!loading.value) {
      paused.value = false
    }
  }
}

const presentToast = async () => {
  checkedIn.value = true
  const toast = await toastController.create({
    message: 'Person successfully checked in!',
    duration: 2500,
    position: 'bottom',
    color: 'success'
  })
  await toast.present()
  setTimeout(() => {
    checkedIn.value = false
  }, 2500)
}

const presentErrorToast = async (message: string) => {
  checkedIn.value = false
  networkError.value = true
  const toast = await toastController.create({
    message: message,
    duration: 5000,
    position: 'bottom',
    color: 'danger'
  })
  await toast.present()
  setTimeout(() => {
    networkError.value = false
  }, 5000)
}

const onError = async (error: Error) => {
  console.error(error)
  if (error.message === 'Requested device not found') {
    await presentErrorToast(`The camera doesn't work`)
  } else await presentErrorToast(error.message)
}

const checkApiKeyAndShowToast = async () => {
  if (
    localStorage.getItem('apiKey') == null ||
    localStorage.getItem('apiKey') === ''
  ) {
    await presentErrorToast('Please enter your API key first')
  }
}
</script>

<style scoped>
ion-modal::part(content) {
  height: 677px;
}

ion-spinner {
  width: 10rem;
  height: 10rem;
  color: var(--ion-color-primary);
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.large-icon {
  font-size: 10rem;
}

.scan-confirmation {
  position: absolute;
  width: 100%;
  height: 100%;
  background-color: rgba(255, 255, 255, 0.8);
  display: flex;
  flex-flow: row nowrap;
  justify-content: center;
  align-items: center;
}
</style>
