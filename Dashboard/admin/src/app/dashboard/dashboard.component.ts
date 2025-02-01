import { Component } from '@angular/core';
import { NavbarComponent } from "../navbar/navbar.component";
import { ChartModule } from 'primeng/chart';
import { isPlatformBrowser } from '@angular/common';
import { CardModule } from 'primeng/card';

import { ChangeDetectorRef, effect, inject, OnInit, PLATFORM_ID } from '@angular/core';
import { HttpClient } from '@angular/common/http';


@Component({
  selector: 'app-dashboard',
  imports: [NavbarComponent,ChartModule,CardModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  basicData: any;
  platformId = inject(PLATFORM_ID);

  ngOnInit() {
    this.initChart();
    this.fetchSalesData();
    
}


constructor(private http: HttpClient) {}

initChart() {
  if (isPlatformBrowser(this.platformId)) {
      const documentStyle = getComputedStyle(document.documentElement);
      const textColor = documentStyle.getPropertyValue('--p-text-color');
      const textColorSecondary = documentStyle.getPropertyValue('--p-text-muted-color');
      const surfaceBorder = documentStyle.getPropertyValue('--p-content-border-color');

      this.basicData = {
          labels: ['Q1', 'Q2', 'Q3', 'Q4'],
          datasets: [
              
          ],
      };

  }
        }
        
        
        fetchSalesData() {
          // Make an API call to your backend (e.g., ASP.NET API) to fetch sales data
          this.http.get<any[]>('admin/api/Dashboard').subscribe(data => {
            // Assume the API returns data with country names and sales count
            const countryNames = data.map(item => item.CountryName);
            const salesData = data.map(item => item.ProductsSold);
      
            // Set chart data dynamically
            this.basicData = {
              labels: countryNames,  // Using country names as labels
              datasets: [
                {
                  label: 'Products Sold',
                  data: salesData,  // Dynamic data for products sold
                  backgroundColor: [
                    'rgba(249, 115, 22, 0.2)',
                    'rgba(6, 182, 212, 0.2)',
                    'rgb(107, 114, 128, 0.2)',
                    'rgba(139, 92, 246, 0.2)',
                  ],
                  borderColor: [
                    'rgb(249, 115, 22)',
                    'rgb(6, 182, 212)',
                    'rgb(107, 114, 128)',
                    'rgb(139, 92, 246)',
                  ],
                  borderWidth: 1,
                },
              ],
            };
          });
        }
}
