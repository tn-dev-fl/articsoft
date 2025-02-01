import { Routes } from '@angular/router';
import { DashboardComponent } from './dashboard/dashboard.component';
import { LoginComponent } from './login/login.component';
import { AuthGuard } from './auth.guard';
import { OrderComponent } from './order/order.component';

export const routes: Routes = [

    {path:'',component:LoginComponent},
    {path:'order',component:OrderComponent},
    {path:'dashboard',component:DashboardComponent,canActivate: [AuthGuard]}

];
