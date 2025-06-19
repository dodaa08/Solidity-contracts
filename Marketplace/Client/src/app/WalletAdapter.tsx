import { useAccount, useConnect, useDisconnect } from 'wagmi';


const WalletAdapter = ()=>{
    const { address, isConnected } = useAccount();
  const { connect, connectors } = useConnect();
  const { disconnect } = useDisconnect();
    return(
        <>
         <div>
      {isConnected ? (
        <>
          <p className='text-2xl py-2'>Connected: {address}</p>
          <button className='border-2 border-gray-200 py-2 px-5 rounded-xl cursor-pointer' onClick={() => disconnect()}>Disconnect</button>
        </>
      ) : (
        connectors.map((connector : any, index : number) => (
            <div key={index}>
          <button className='border-2 border-gray-200 py-2 px-5 rounded-xl cursor-pointer' key={connector.id} onClick={() => connect({ connector })}>
            Connect with {connector.name}
          </button>
            </div>
        ))
      )}
    </div>
        </>
    )
}


export default WalletAdapter;