using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Website
{
    public class Utility
    {
        public static string cnn = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        public static SqlConnection con = new SqlConnection(cnn);
        public static bool CheckKey(string sql)
        {
            SqlDataAdapter ad = new SqlDataAdapter(sql, con);
            DataTable tb = new DataTable();
            ad.Fill(tb);
            if (tb.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}