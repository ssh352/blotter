#' The Almgren-Chriss Market Impact Model
#' 
#' In theri proposed modeling framework Almgren-Chriss consider the following 
#' trade-off that ultimately determines the transaction cost: on one hand a 
#' trader may modulate the trading rate in order to decrease the \emph{volatility risk}
#' exposure to secutities prices fluctuations, on the other the rate of exection 
#' has the effect of increasing the transaction cost through the price impact these 
#' trades generate.
#' This so called \emph{trader dilemma} can be conxtualized from two equivalent 
#' points of view, maximize the expected trading revenues or minimize the expected 
#' transaction costs, for any given trader's \emph{risk tolerance} as captured by 
#' the \emph{risk-aversion} coefficient \eqn{\gamma}.
#' The authors' fundamental idea of \emph{optimal liquidation} is to find
#' which trading trajectory minimizes the trade-off.
#' 
#' @section The trading model:
#' Among the authors assumptions is there the security price dynamic is driven by
#' a \emph{discrete arithmetic random-walk} with independent increments, furthermore
#' - following their extended discussion - a drift is permitted. As known it allows 
#' to incorporate directional views on the traded security price, however it may
#' result in changed signs of the optimal trajectories computed (e.g. there may be
#' buy trades in a selling program). Also, in light of the short-term trading horizons 
#' considered, the authors do not consider other procecesses nor carry or time-value 
#' of money.
#' Another assumption is with respect to the equally spaced interval between the
#' trading discrete times, \eqn{\tau = T/N} where \eqn{T} is the time the execution
#' program has to be completed and \eqn{N} represents the number of intervals the
#' among the trading times.
#' With respect to the impact functions, although not strictly necessary, we follow 
#' the authors' seminal work and assume linear forms. It is a simplification that
#' as we shall specify shortly allows to provide explicit solutions to the optimization
#' problem posed.
#' Permanent and temporary impact are functions of the \emph{average trading rate},
#' \eqn{v_{k} = n_{k}/\eta}.
#' 
#' \bold{Permanent market impact}. Sometimes described as "information leakeage"
#' is an ebrilibrium-changing in the security price during the trading times, i.e
#' an influence on its dynamic, that we write as:
#' 
#' \deqn{S_{k} = S_{k-1} + \sigma*\sqrt{\tau}*\psi_{k} + \mu*\tau - \tau*g(v_{k})} 
#' 
#' where \eqn{\psi} is a standard normal random variable, \eqn{\mu} is the security
#' price drift and \eqn{\sigma} is the security price volatility. The function 
#' \eqn{g(v_{k})} is the linear permanent impact function
#' 
#' \deqn{g(v_{k}) = \gamma * v_{k}}
#' 
#' the parameter impact \eqn{\gamma} permanent impact parameter can be seen as a
#' fixed cost independent of the trajectory (and is expressed in (currency/trade-unit)/trade-unit).
#' 
#' \bold{Temporary market impact}. The execution of a sufficiently large \eqn{n_{k}} 
#' units between times \eqn{t_(k - 1)} and \eqn{t_k} may influence the price of 
#' the traded asset. The impact is always against the trader in that buying (selling) 
#' a too large number of units may increase (decrease) its price. Due to this impact 
#' the effective price per traded unit on the \eqn{k}-th transaction is:
#' 
#' \deqn{\hat{S}_{k} = S_{k-1} - h(v_{k})}
#' 
#' with \eqn{h(v_{k})}, the linear temporary impact function, defined as:
#' 
#' \deqn{h(v_{k}) = \epsilon * sgn(n_{k}) + \eta * v_{k}}
#' 
#' the parameter \eqn{\epsilon} is expressed in currency/trade-unit, authors report
#' that a reasonable estimate for is the fixed costs of trading, such as half the 
#' bid-ask spread plus fees; the temporary impact parameter \eqn{\eta} is expressed
#' in (currency/trade-unit)/(trade-unit/time) and is reportedly more difficult to 
#' estimate.
#' Associated with any given trading trajectory there is a \emph{capture trajectory},
#' and a \emph{total cost of trading}.
#' The former is the full trading revenue upon completion of all trades:
#' 
#' \deqn{\sum{n_{k} * \hat{S}_{k}}}
#' 
#' Whereas the latter is the difference between the portfolio value at the beginning
#' of trading (book value) and the capture trajectory:
#' 
#' \deqn{X*S_{0} - \sum{n_{k} * \hat{S}_{k}}}
#' 
#' this is Perold's (ex-post) \emph{implementation shortfall}.
#' 
#' @section The optimization problem:
#' A rational trader seeks to minimize the expectation of shortfall, for a given 
#' level of variance of shortfall. For each level of risk aversion there is a uniquely 
#' determined \emph{optimal trading strategy}.
#' The optimization problem Almgren-Chriss posed aims to find such a strategy, 
#' which has lower variance for the same or lower level of expected transaction 
#' costs, or, equivalently, no strategy which has a lower level of expected 
#' transaction costs for the same or lower level of variance.
#' Mathematically the problem is posed as:
#' 
#' \deqn{min[E(x) + \lambda * V(x)]}
#' 
#' where the \emph{expected shortfall} \eqn{E(x)} is the expectation of impact costs 
#' in \eqn{k = 1,...,N}:
#' 
#' \deqn{E(x) = 0.5*\gamma*X^2 - \mu*\sum{\tau*x_{j}} + \epsilon*\sum{|n_{k}|} + (\eta - 0.5*\gamma*\tau)*\sum{n_{k}^2}}
#' 
#' \eqn{k = 1,...,N}.
#' 
#' and the \emph{variance of the shortfall} \eqn{V(x)} is
#' 
#' \deqn{V(x) = \sigma^2 * \sum{\tau*x_{j}^2}}
#' 
#' The Lagrange multiplier \eqn{\lambda} is interpreted as a measure of risk 
#' aversion, that is how much the variance is penalized with respect to the to expected cost.
#' The solution of this problem depends on the specified forms of the impact functions.
#' Fot the linear case assumed explicit solutions of the optimal holding trajectory 
#' and as a consequence of the associated optimal trade trajectory exist. They 
#' are respectively 
#' 
#' \deqn{
#' x_{j} = \frac{{sinh[\kappa(T - t_{j})]}{sinh(\kappa * T)}} * X
#'         + (1 - frac{sinh[\kappa*(T - t_{j})] + sinh(\kappa*t_{j})}{sinh(\kappa*T)}) * \bar{x}
#' }
#' 
#' \deqn{
#' n_{j} = \frac{2*sinh(0.5*\kappa*\tau)}{sinh(\kappa * T)} * cosh(\kappa(T - (j - 0.5)*\tau) * X
#'         + 2 * sinh[1/2*\kappa*\tau]/sinh(\kappa*T) * (cosh[\kappa * t_{j - 1/2}] - cosh[\kappa * (T - t_{j - 1/2})]) * \bar{x}
#' }
#' 
#' where \eqn{\bar{x} = \mu/2*\lambda*\sigma^2} is the optimal level of security 
#' holding for a time-independent porfolio and allows to incorporate a drift correction
#' into the optimal trajectories dynamics, when the hypothesized drift term is not null.
#' 
#' The parameter \eqn{\kappa}, sometimes called the \emph{urgency parameter}, expresses 
#' the curvature of the optimal trajectory, approximated for small equally spaced 
#' trade periods, that is:
#' 
#' \deqn{\kappa ~ \sqrt{\lambda*\sigma^2/\eta} + O(\tau)}
#' 
#' as \eqn{\tau -> 0}.
#' 
#' Also \eqn{\kappa} provides an interesting interpretation in terms of the time
#' needed to complete the order. Rewriting:
#' 
#' \deqn{\theta = \frac{1}{\kappa}}
#' 
#' the so called \emph{half-life of a trade} is evident that the larger the value 
#' of \eqn{\kappa} and the smaller the time \eqn{\theta} needed deplete the execution, 
#' that is the rapidly the trade schedule will be completely executed. In other
#' terms it can be seen as a measure of the liquidity of the traded security.
#' 
#' As long as \eqn{\lambda \geq 0} there exists a unique minimizer \eqn{x^{*}(k)}.
#' Resolving the optimization problems with respect to different such values of 
#' \eqn{\lambda} leads to the \emph{efficient frontier}, that is the locus of the 
#' optimal trading strategies where each strategy has the minimum transaction cost 
#' for a given level of volatility or the minimun volatility for a given amount 
#' of transaction costs (i.e. cost-volatility optimal combinations).
#' The frontier is a smooth convex function, differentiable at its minimal point
#' which is what the authors call the \emph{naive strategy}, corresponding to trading 
#' at a constant rate.
#' 
#' It is important to stress how under the above context the optimal execution 
#' trajectories can be statically determined.
#' This is not always exactly true, as there could be serial correlation effects 
#' and paramters shifts due to regime changes (news, events, etc.). However the 
#' author shows how even in that case optimal trajectory are piecewise static and
#' notwithstanding that gains from introducing these components into the dynamics 
#' is argued to be negligible for large portfolios with respect to the impact costs.
#'
#' @references 
#' \emph{Value Under Liquidation} (Almgren and Chriss, 1999), working paper. \url{https://www.math.nyu.edu/faculty/chriss/optliq_r.pdf}
#' \emph{Optimal Execution of Portfolio Transactions} (Almgren and Chriss, 2000), Journal of Risk. \url{http://corp.bankofamerica.com/publicpdf/equities/Optimal_Execution.pdf}
#' 
#' @author Vito Lestingi
#' 
#' @param Securities A \code{data.frame} with required columns 'Symbol', 'Init.Price', 'Units' (total number of units to liquidate), 'Complete.by' (total time for liquidation), 'Trade.Periods' (number of periods, in terms of 'Complete.by')
#' @param mu A numeric value, the drift of the traded security price. Default is zero
#' @param sigma A numeric value, the volatility of the traded security price
#' @param gamma A numeric value, the permanent impact parameter
#' @param epsilon A numeric value, a temporary impact parameter. Default is the bid-ask spread midpoint plus fees 
#' @param eta A numeric value, a temporary impact parameter
#' @param lambda A numeric value, expressing the risk tolerance  
#' 
#' @return
#' A list containing the following elements:
#' 
#' \describe{
#'   \item{\code{Optimal.Trajs}: }{
#'     A \code{data.frame} with optimal trajectories of the units to hold (\code{Opt.Hold}), 
#'     trade (\code{Opt.Trade}) and of the transactions impacts (\code{Perm.Impact} \code{Term.Impact})
#'     incurred in the liquidating the security.
#'     }
#'   \item{\code{Optimal.Comb}: }{The optimal stragegy associated expectation shortfall (\code{E(x)}), expressed in the security currency, and variance of the shortfall (\code{V(x)}), expressed in the security currency squared}
#'   \item{\code{Strategy.Tot}: }{Overall measures associated with the optimal strategy}
#' }
#' 
#' @details 
#' In the \code{Securities} input object values have the following meaning:
#' 'Symbol' is the traded security name, 'Init.Price' is the price of the security
#' at the time the trading program begins, 'Units' is the total number of units 
#' to liquidate (e.g. shares, number of contracts), 'Complete.by' is the given total 
#' time for liquidation in numeric terms (e.g. 1 day), 'Trade.Periods' is number 
#' of trading periods in between the program (expressed in terms of 'Complete.by').
#' 
#' @examples 
#' 
#' @export
#'
acOptTxns <- function(Securities
                      , mu = 0
                      , sigma
                      , gamma
                      , epsilon = NULL
                      , eta
                      , lambda) 
{ 
  if (is.null(epsilon)) {
    epsilon <- 0.5 * (Securities[, 'Ask'] + Securities[, 'Bid']) + Securities[, 'Fees']
  }
  
  # Time interval lenght and discrete times
  tau <- Securities[, 'Complete.By']/Securities[, 'Trade.Periods']
  t <- seq(0, Securities[, 'Complete.By'], tau)
  
  # Explicit solutions
  kappa <- (lambda * sigma^2)/(eta * (1 - 0.5*gamma*tau/eta)) + tau 
  # kappa_hat_sq <- (lambda * sigma^2)/(eta * (1 - 0.5*gamma*tau/eta))
  # kappa <- 1/tau * acosh(0.5 * tau^2 * kappa_hat_sq + 1) 
  # kappa <- sqrt((lambda * sigma^2)/(eta * (1 - 0.5*gamma*tau/eta)) + tau^2)
  halfLife <- 1/kappa
  if (mu == 0 & lambda == 0) {
    x_bar <- 0
  } else {
    x_bar <- 0.5 * mu/lambda*sigma^2
  }
  t_half <- (1:Securities[, 'Trade.Periods'] - 0.5) * tau
  # optimal holding trajectory
  optHoldTraj <- (sinh(kappa * (Securities[, 'Complete.By'] - t))/sinh(kappa * Securities[, 'Complete.By'])) * Securities[, 'Units']
  holdTrajDriftCorrection <- (1 - sinh(kappa*(Securities[, 'Complete.By'] - t)) + sinh(kappa*t)/sinh(kappa*Securities[, 'Complete.By'])) * x_bar
  optHoldTraj <- optHoldTraj + holdTrajDriftCorrection
  # optimal trading trajectory
  optTradeTraj <- (2 * sinh(0.5 * kappa * tau)/sinh(kappa * Securities[, 'Complete.By'])) * cosh(kappa*(Securities[, 'Complete.By'] - t_half)) * Securities[, 'Units']
  tradeTrajDriftCorrection <- 2 * sinh(0.5*kappa*tau)/sinh(kappa*Securities[, 'Complete.By']) * (cosh(kappa * t_half) - cosh(kappa * (Securities[, 'Complete.By'] - t_half))) * x_bar
  optTradeTraj <- optTradeTraj + tradeTrajDriftCorrection
  
  # Impact functions
  g <- function(gamma, tradeTraj, tau) gamma * tradeTraj/tau                                  # permanent
  h <- function(epsilon, eta, tradeTraj, tau) epsilon * sign(tradeTraj) + eta * tradeTraj/tau # temporary
  
  # Security price dynamics
  permImpactTraj <- g(gamma, optTradeTraj, tau)
  secPriceDyn <- cumsum(c(Securities[, 'Init.Price'], mu * tau + sigma * sqrt(tau) * rnorm(Securities[, 'Trade.Periods']) - tau * permImpactTraj))
  tempImpactTraj <- h(epsilon, eta, optTradeTraj, tau)
  secNetPriceDyn <- secPriceDyn[-1] - tempImpactTraj
  
  # Expected shortfall and shortfall variance
  permImpact <- 0.5 * gamma * Securities[, 'Units']^2 - mu * tau * sum(optHoldTraj[-1]^2)
  tempImpact <- epsilon * sum(abs(optTradeTraj)) + (eta/tau - 0.5*gamma) * sum(optTradeTraj^2)
  expShortfall <- permImpact + tempImpact
  varShortfall <- sigma^2 * tau * sum(optHoldTraj^2)
  # expShortfall <- 0.5 * gamma * Securities[, 'Units']^2 + epsilon * Securities[, 'Units'] +
  #   (eta - 0.5*gamma*tau) * Securities[, 'Units']^2 * tanh(0.5*kappa*tau) * (tau*sinh(2*kappa*Securities[ ,'Complete.By']) + 2*Securities[ ,'Complete.By']*sinh(kappa*tau))/2*tau^2*(sinh(kappa*Securities[, 'Complete.By']))^2
  # varShortfall <- 0.5 * sigma^2 * Securities[, 'Units']^2 *
  #   (tau*sinh(kappa*Securities[, 'Complete.By']) * cosh(kappa*(Securities[, 'Complete.By'] - tau)) - Securities[, 'Complete.By']*sinh(kappa*tau))/((sinh(kappa*Securities[, 'Complete.By'])^2 * sinh(kappa*tau)))
  tradeCapt <- sum(optTradeTraj * secNetPriceDyn)
  tradeCost <- Securities[, 'Units'] * Securities[, 'Init.Price'] - tradeCapt
  maxDriftGain <- mu*x_bar*Securities[, 'Complete.By'] * (1 - tau/Securities[, 'Complete.By'] * (tanh(0.5*kappa*Securities[, 'Complete.By'])/tanh(0.5*kappa*tau))) 
  
  out <- vector('list', 3)
  out[['Optimal.Trajs']] <- as.data.frame(cbind('Opt.Hold' = optHoldTraj, 'Opt.Trade' = c(optTradeTraj, NA), 'Perm.Impact' = c(permImpactTraj * optTradeTraj, NA), 'Temp.Impact' = c(tempImpactTraj * optTradeTraj, NA)))
  out[['Optimal.Comb']] <- c('E(x)' = expShortfall, 'V(x)' = varShortfall)
  out[['Strategy.Tot']] <- c('Cap.Traj' = tradeCapt, 'Trade.Cost' = tradeCost, 'Perm.Impact.Cost' = sum(permImpactTraj * optTradeTraj), 'Temp.Impact.Cost' = sum(tempImpactTraj * optTradeTraj), 'Half.Life' = halfLife, 'Max.Drift.Gain' = maxDriftGain)
  return(out)
}
