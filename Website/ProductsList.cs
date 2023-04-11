using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website
{
    public class ProductsList
    {
        public string id { get; set; }
        public string img { get; set; }
        public string name { get; set; }
        public string price { get; set; }
        public string detail_heading { get; set; }
        public string detail { get; set; }
        public string type { get; set; }
        public string color { get; set; }
        public ProductsList()
        {

        }
        public ProductsList(string id, string img, string name, string price, string detail_heading, string detail, string type, string color)
        {
            this.id = id;
            this.img = img;
            this.name = name;
            this.price = price;
            this.detail_heading = detail_heading;
            this.detail = detail;
            this.type = type;
            this.color = color;
        }
    }
}