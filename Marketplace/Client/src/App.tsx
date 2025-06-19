import { BrowserRouter, Routes, Route } from "react-router-dom";
import Connector from "./app/Connector";
import Landing from "./app/Landing";

const App = ()=>{
  const routes : any = [
    {
      path : "/",
      element : <Landing />
    }
  ];
  return(
    <>
     <BrowserRouter>
      <Routes>
         {
           routes.map((route : any, index : any)=>(
             <Route key={index} path={route.path}  element={route.element} />
            ))
          }
      </Routes>
    </BrowserRouter>

    </>
  )
}

export default App;

