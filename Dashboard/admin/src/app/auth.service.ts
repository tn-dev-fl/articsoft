import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
interface LoginResponse {
  token: string;
}

@Injectable({
  providedIn: 'root'
})

export class AuthService {

  constructor(private http: HttpClient) {}

  login(loginData: any): Observable<LoginResponse> {
    return this.http.post<LoginResponse>('/admin/api/login', loginData);
  }
}
