import { Component } from '@angular/core';
import { CardModule } from 'primeng/card';
import { NavbarComponent } from '../navbar/navbar.component';
import { ItemService } from '../item.service';
import { FormsModule } from '@angular/forms';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { HttpClient } from '@angular/common/http';
import { FloatLabel } from 'primeng/floatlabel';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';

import { OrderService } from '../order.service';  // Import the order service


@Component({
  selector: 'app-order',
  imports: [CardModule,NavbarComponent,AutoCompleteModule,FormsModule,FloatLabel,ButtonModule,InputTextModule],
  templateUrl: './order.component.html',
  standalone:true,
  styleUrl: './order.component.css'
})
export class OrderComponent {
  items: any[] = [];  // Store the items retrieved from the backend
  selectedItem: any = null;  // Store the selected item for ngModel binding
  item:any;
  Quantity:any;

  constructor(private http: HttpClient,private orderService : OrderService) {}

  Submit() {
      // Call the service to submit the order
      this.orderService.submitOrder(this.item.Id, this.Quantity).subscribe(
        response => {
          // Handle success response
          if (response.success) {
            alert('Order placed successfully!');
          } else {
            // Handle failure (e.g., not enough stock)
            alert('Error: ' + response.message);
          }
        },
        error => {
          // Handle general errors (e.g., network issues)
          alert('An error occurred while processing your order: ' + error.message);
        }
      );
  
  }
  search(event: any) {
    const query = event.query;  
    
    this.http.get<any[]>(`admin/api/items?search=${query}`).subscribe(
      data => {
        this.items = data;
      },
      error => {
        console.error('Error fetching data:', error);
      }
    );
  }

}
