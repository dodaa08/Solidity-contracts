import { createConfig, http } from 'wagmi';
import { mainnet, sepolia } from 'wagmi/chains';

const config = createConfig({
  chains: [mainnet, sepolia],
  transports: {
    [sepolia.id]: http('https://eth-sepolia.g.alchemy.com/v2/6TgXrroVUQ6IWKynounZO4ICRirNm3FJ'),
  },
});

export default config;
