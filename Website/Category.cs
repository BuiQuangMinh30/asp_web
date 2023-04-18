using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website
{
    public class Category
    {
        //Class để nhận json được gửi đến server
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }
}