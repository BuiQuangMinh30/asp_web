using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Website
{
    public class ListViewItemComparer 
    {
        private int col;
        private SortOrder order;

        public ListViewItemComparer()
        {
            col = 0;
            order = SortOrder.Ascending;
        }

        public ListViewItemComparer(int column, SortOrder order)
        {
            col = column;
            this.order = order;
        }

        //public int Compare(object x, object y)
        //{
        //    int returnVal;
        //    string xText = ((ListViewItem)x).SubItems[col].Text;
        //    string yText = ((ListViewItem)y).SubItems[col].Text;

        //    if (col == 0) // column of type string
        //    {
        //        returnVal = String.Compare(xText, yText);
        //    }
        //    else // column of type integer
        //    {
        //        int xValue = int.Parse(xText);
        //        int yValue = int.Parse(yText);
        //        returnVal = xValue.CompareTo(yValue);
        //    }

        //    // Reverse the order for descending.
        //    if (order == SortOrder.Descending)
        //    {
        //        returnVal *= -1;
        //    }

        //    return returnVal;
        //}
    }
    
}