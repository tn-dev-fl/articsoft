import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

interface Item {
  id: number;
  name: string;
}

@Injectable({
  providedIn: 'root'
})
export class ItemService {

  private apiUrl = '/api/item';  // Replace with your API endpoint

  constructor(private http: HttpClient) {}

  // Method to fetch the items from the API
  getItems(): Observable<Item[]> {
    return this.http.get<Item[]>(this.apiUrl);
  }
}
