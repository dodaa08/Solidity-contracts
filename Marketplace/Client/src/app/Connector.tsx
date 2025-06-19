import { WagmiProvider } from 'wagmi';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import config from '../config';
import WalletAdapter from './WalletAdapter';

// ✅ Keep queryClient outside the component
const queryClient = new QueryClient();

function Connector() {
  return (
    <QueryClientProvider client={queryClient}>
      <WagmiProvider config={config}>
        <WalletAdapter />
      </WagmiProvider>
    </QueryClientProvider>
  );
}

export default  Connector;
