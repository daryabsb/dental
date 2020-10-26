<template>
    <div class="row vh-100 ">
            <div class="col-12 align-self-center">
                <div class="auth-page">
                    
                   <div class="card auth-card shadow-lg">
                        <div class="card-body">
                            <div class="px-3">
                                <div class="auth-logo-box">
                                    <a href="../analytics/analytics-index.html" class="logo logo-admin"><img src="../assets/images/logo-sm.png" height="55" alt="logo" class="auth-logo"></a>
                                </div><!--end auth-logo-box-->
                                
                                <div class="text-center auth-logo-text">
                                    <h4 class="mt-0 mb-3 mt-5">Free Register for Metrica</h4>
                                    <p class="text-muted mb-0">Get your free Metrica account now.</p>  
                                </div> <!--end auth-logo-text-->  

                                
                                <form class="form-horizontal auth-form my-4" action="index.html">
        
                                    <div class="form-group">
                                        <label for="username">Username</label>
                                        <div class="input-group mb-3">
                                            <span class="auth-form-icon">
                                                <i class="dripicons-user"></i> 
                                            </span>                                                                                                              
                                            <input type="text" class="form-control" id="username" placeholder="Enter username">
                                        </div>                                    
                                    </div><!--end form-group--> 

                                    <div class="form-group">
                                        <label for="useremail">Email</label>
                                        <div class="input-group mb-3">
                                            <span class="auth-form-icon">
                                                <i class="dripicons-mail"></i> 
                                            </span>                                                                                                              
                                            <input type="email" class="form-control" id="useremail" placeholder="Enter Email">
                                        </div>                                    
                                    </div><!--end form-group-->
        
                                    <div class="form-group">
                                        <label for="userpassword">Password</label>                                            
                                        <div class="input-group mb-3"> 
                                            <span class="auth-form-icon">
                                                <i class="dripicons-lock"></i> 
                                            </span>                                                       
                                            <input type="password" class="form-control" id="userpassword" placeholder="Enter password">
                                        </div>                               
                                    </div><!--end form-group--> 

                                    <div class="form-group">
                                        <label for="conf_password">Confirm Password</label>                                            
                                        <div class="input-group mb-3"> 
                                            <span class="auth-form-icon">
                                                <i class="dripicons-lock-open"></i> 
                                            </span>                                                       
                                            <input type="password" class="form-control" id="conf_password" placeholder="Enter Confirm Password">
                                        </div>  
                                        
                                        <div class="form-group">
                                            <label for="mo_number">Mobile Number</label>                                            
                                            <div class="input-group mb-3"> 
                                                <span class="auth-form-icon">
                                                    <i class="dripicons-phone"></i> 
                                                </span>                                                       
                                                <input type="text" class="form-control" id="mo_number" placeholder="Enter Mobile Number">
                                            </div>                               
                                        </div><!--end form-group--> 
                                    </div><!--end form-group--> 
        
                                    <div class="form-group row mt-4">
                                        <div class="col-sm-12">
                                            <div class="custom-control custom-switch switch-success">
                                                <input type="checkbox" class="custom-control-input" id="customSwitchSuccess">
                                                <label class="custom-control-label text-muted" for="customSwitchSuccess">By registering you agree to the Frogetor <a href="#" class="text-primary">Terms of Use</a></label>
                                            </div>
                                        </div><!--end col-->                                             
                                    </div><!--end form-group--> 
        
                                    <div class="form-group mb-0 row">
                                        <div class="col-12 mt-2">
                                            <button class="btn btn-primary btn-round btn-block waves-effect waves-light" type="submit">Register <i class="fas fa-sign-in-alt ml-1"></i></button>
                                        </div><!--end col--> 
                                    </div> <!--end form-group-->                           
                                </form><!--end form-->
                            </div><!--end /div-->
                            
                            <div class="m-3 text-center text-muted">
                                <p class="">Already have an account ? <a href="../authentication/auth-login.html" class="text-primary ml-2">Log in</a></p>
                            </div>
                        </div><!--end card-body-->
                    </div>
                    
                    <div class="account-social text-center mt-4">
                        <h6 class="my-4">Or Login With</h6>
                        <ul class="list-inline mb-4">
                            <li class="list-inline-item">
                                <a href="" class="">
                                    <i class="fab fa-facebook-f facebook"></i>
                                </a>                                    
                            </li>
                            <li class="list-inline-item">
                                <a href="" class="">
                                    <i class="fab fa-twitter twitter"></i>
                                </a>                                    
                            </li>
                            <li class="list-inline-item">
                                <a href="" class="">
                                    <i class="fab fa-google google"></i>
                                </a>                                    
                            </li>
                        </ul>
                    </div><!--end account-social-->
                </div><!--end auth-page-->
            </div><!--end col-->           
        </div><!--end row-->
        <!-- End Log In page -->
        
            
</template>

<script>
export default {
    middleware: 'auth',
    auth: 'guest',
    layout: 'auth',
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    async onLogin() {
      try {
          console.log(this.email, ' / ', this.password)
        let loginfo = this.$auth.loginWith('local', {
          data: {
            email: this.email,
            password: this.password
          }
          
        });
        console.log(Loginfo)
        this.$router.push('/patients/')
      } catch (err) {
        console.log(err)
      }
    }
  }
}
</script>