using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TicketBookingSystem.exception
{
    public class InvalidBookingIDException : Exception
    {
        public InvalidBookingIDException() : base("Invalid booking ID!") { }

        public InvalidBookingIDException(string message) : base(message) { }
    }
}