using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website
{
    public class CartDetail
    {
        public int iDonHangId { get; set; }
        public int iSanPhamId { get; set; }
        public int iChiTietDonHangId { get; set; }
        public int iSoLuong { get; set; }
        public float fDonGia { get; set; }

        public CartDetail()
        {

        }
        public CartDetail(int iChiTietDonHangId, int iDonHangId, int iSanPhamId, float fDonGia, int iSoLuong)
        {
            this.iChiTietDonHangId = iChiTietDonHangId;
            this.iDonHangId = iDonHangId;
            this.iSanPhamId = iSanPhamId;
            this.fDonGia = fDonGia;
            this.iSoLuong = iSoLuong;
        }
    }
}