import { CapacitorConfig } from '@capacitor/cli'

const config: CapacitorConfig = {
  appId: 'fl0r1an.ticket.inspector',
  appName: 'TicketInspector',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  }
}

export default config
