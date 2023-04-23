using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website
{
    public class CartItem
    {
        public int iDonHangId { get; set; }
        public int iSanPhamId { get; set; }
        public string sTenSanPham { get; set; }
        public string sAnh { get; set; }
        public int iSoluong { get; set; }
        public float fDonGia { get; set; }
    }

}