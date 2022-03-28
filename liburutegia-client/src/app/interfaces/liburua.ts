import { Idazlea } from './idazlea';

export interface Liburua {
  IdLiburua: number;
  ISBN: string;
  Izenburua: string;
  OrriKopurua: number;
  Generoa: string;
  Urtea: number;
  Irudia: string;
  Stock : number;
  Idazlea : Idazlea;
}
