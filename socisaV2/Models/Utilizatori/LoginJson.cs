using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace socisaWeb
{
    public class LoginJson
    {
        //[Required]
        //[Display(Name = "Utilizator")]
        [Display(Name = "USERNAME", ResourceType = typeof(socisaV2.Resources.LoginResx))]
        public string Username { get; set; }

        //[Required]
        [DataType(DataType.Password)]
        //[Display(Name = "Parola")]
        [Display(Name = "PASSWORD", ResourceType = typeof(socisaV2.Resources.LoginResx))]
        public string Password { get; set; }

        [Display(Name = "CODE", ResourceType = typeof(socisaV2.Resources.LoginResx))]
        public string Code { get; set; }

        public LoginJson()
        {
            Code = "";
        }
    }
}