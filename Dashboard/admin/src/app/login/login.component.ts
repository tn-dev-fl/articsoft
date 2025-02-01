import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CardModule } from 'primeng/card';
import { InputTextModule } from 'primeng/inputtext';
import { FloatLabel } from 'primeng/floatlabel';
import { HttpClient } from '@angular/common/http';
import { PasswordModule } from 'primeng/password';

import { ButtonModule } from 'primeng/button';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router'; 
interface LoginResponse {
  token: string;
}

@Component({
  selector: 'app-login',
  imports: [CardModule,InputTextModule,FormsModule,FloatLabel,ButtonModule,PasswordModule],
  templateUrl: './login.component.html',
  standalone: true, 
  styleUrl: './login.component.css'
})
export class LoginComponent {
  username: string='';
  password:string='';
 

  constructor(private authService: AuthService,private router: Router) {};
  onLogin() {
    const loginData = {
      username: this.username,
      password: this.password
    };

    this.authService.login(loginData).subscribe(
      (response: LoginResponse) => {
        const token = response.token;
        localStorage.setItem('authToken', token); // Store the token
        console.log('Login successful', response);
        this.router.navigate(['/dashboard']);
      },
      (error: any) => {
        console.error('Login failed', error);
      }
    );
    
  }
}

