using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
	public partial class AdminCategoryList : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			getAll_DanhMuc();
		}

		protected void getAll_DanhMuc()
		{
			Utility utility = new Utility();
			DataTable tb = utility.getAll_DanhMuc();
			listDanhMuc.DataSource = tb;
			listDanhMuc.DataBind();
		}
	}
}