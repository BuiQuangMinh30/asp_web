using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website
{
    public class ProductsList
    {
        public int iSanPhamId { get; set; }
        public string sAnh { get; set; }
        public string sTenSanPham { get; set; }
        public float fDonGia { get; set; }
        public string sMoTa { get; set; }
        public int iDanhMucId { get; set; }
        public string dThoiGianTao { get; set; }
        public ProductsList()
        {

        }
        public ProductsList(int iSanPhamId, string sAnh, string sTenSanPham, 
            float fDonGia, string sMoTa,  int iDanhMucId, string dThoiGianTao)
        {
            this.iSanPhamId = iSanPhamId;
            this.sAnh = sAnh;
            this.sTenSanPham = sTenSanPham;
            this.fDonGia = fDonGia;
            this.sMoTa = sMoTa;
            this.iDanhMucId = iDanhMucId;
            this.dThoiGianTao = dThoiGianTao;
        }
    }
}