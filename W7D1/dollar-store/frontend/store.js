import { createStore } from 'redux';
import reducer from './reducer';

const store = createStore(reducer);

//when one export, export default
export default store;
