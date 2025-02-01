import { Component } from '@angular/core';
import { MenuItem } from 'primeng/api';
import { Menubar } from 'primeng/menubar';

@Component({
  selector: 'app-navbar',
  imports: [Menubar],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {

  items: MenuItem[] | undefined;

  ngOnInit() {
      this.items = [
          {
              label: 'Dashboard',
              icon: 'pi pi-home',
              routerLink: '/dashboard'
          },
          {
              label: 'Order',
              icon: 'pi pi-star',
              routerLink: '/order'
          },
          
      ]
  }
}
