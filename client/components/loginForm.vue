 <<template>
     
 <div class="card auth-card shadow-lg">
                        <div class="card-body">
                            <div class="px-3 mb-3">
                                <div class="auth-logo-box">
                                    <a href="../analytics/analytics-index.html" class="logo logo-admin"><img src="~assets/images/logo-sm-2.png" height="55" alt="logo" class="auth-logo"></a>
                                </div><!--end auth-logo-box-->
                                
                                <div class="text-center auth-logo-text">
                                    <h4 class="mt-0 mb-3 mt-5">Let's Get Started Metrica</h4>
                                    <p class="text-muted mb-0">Sign in to continue to Metrica.</p>  
                                </div> <!--end auth-logo-text-->  
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <div class="input-group mb-3">
                                            <span class="auth-form-icon">
                                                <i class="dripicons-user"></i> 
                                            </span>                                                                                                              
                                            <input v-model="email" type="text" class="form-control" id="email" placeholder="Enter a valid email">
                                        </div>                                    
                                    </div><!--end form-group--> 
        
                                    <div class="form-group">
                                        <label for="userpassword">Password</label>                                            
                                        <div class="input-group mb-3"> 
                                            <span class="auth-form-icon">
                                                <i class="dripicons-lock"></i> 
                                            </span>                                                       
                                            <input v-model="password" type="password" class="form-control" id="userpassword" placeholder="Enter password">
                                        </div>                               
                                    </div><!--end form-group--> 
        
                                    <div class="form-group row mt-4">
                                        <div class="col-sm-6">
                                            <div class="custom-control custom-switch switch-success">
                                                <input type="checkbox" class="custom-control-input" id="customSwitchSuccess">
                                                <label class="custom-control-label text-muted" for="customSwitchSuccess">Remember me</label>
                                            </div>
                                        </div><!--end col--> 
                                        <div class="col-sm-6 text-right">
                                            <a href="auth-recover-pw.html" class="text-muted font-13"><i class="dripicons-lock"></i> Forgot password?</a>                                    
                                        </div><!--end col--> 
                                    </div><!--end form-group--> 
        
                                    <div class="form-group mb-0 row">
                                        <div class="col-12 mt-2">
                                            <button class="btn btn-primary btn-round btn-block waves-effect waves-light" @click="onLogin">Log In <i class="fas fa-sign-in-alt ml-1"></i></button>
                                        </div><!--end col--> 
                                    </div> <!--end form-group-->                           
                            </div><!--end /div-->
                            
                           
                        </div><!--end card-body-->
                    </div><!--end card-->

 </template>
<script>
export default {
    middleware: 'auth',
    auth: 'guest',
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