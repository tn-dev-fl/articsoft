import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class OrderService {
  private apiUrl = 'admin/api/submit'; // URL of your backend API

  constructor(private http: HttpClient) { }

  // Method to submit an order
  submitOrder(productId: number, quantity: number): Observable<any> {
    const body = { id: productId, quantity: quantity };

    return this.http.post<any>(this.apiUrl, body);

  }
}
