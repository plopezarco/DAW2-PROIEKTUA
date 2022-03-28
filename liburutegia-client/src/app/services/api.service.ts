import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Idazlea } from '../interfaces/idazlea';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private url = "http://localhost:8081/"
  constructor(private http:HttpClient) { }

  getIdazleak(): Observable<Idazlea[]>{
    return this.http.get<Idazlea[]>(this.url + "/idazleak");
  }

}
